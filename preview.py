#!/usr/bin/env python3
"""preview.py <in.stl> <out.png> [azimuth elevation]: tiny z-buffer renderer, standard library only.
OpenSCAD's own PNG export needs a GPU/X server, which this box lacks."""
import math, re, struct, sys, zlib


def load(path):
    data = open(path, 'rb').read()
    tris = []
    if data[:5] == b'solid' and b'facet' in data[:400]:
        v = [tuple(map(float, m)) for m in re.findall(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', data)]
        tris = [v[i:i + 3] for i in range(0, len(v), 3)]
    else:
        n = struct.unpack_from('<I', data, 80)[0]
        for i in range(n):
            f = struct.unpack_from('<12f', data, 84 + i * 50)
            tris.append([f[3:6], f[6:9], f[9:12]])
    return tris


def render(tris, az=-35, el=30, W=1000, H=800):
    a, e = math.radians(az), math.radians(el)
    ca, sa, ce, se = math.cos(a), math.sin(a), math.cos(e), math.sin(e)

    def rot(p):
        x, y, z = p
        x, y = x * ca - y * sa, x * sa + y * ca          # spin about z
        return x, y * ce - z * se, y * se + z * ce        # (right, depth, up)

    T = [[rot(p) for p in t] for t in tris]
    xs = [p[0] for t in T for p in t]
    ys = [p[2] for t in T for p in t]
    s = 0.9 * min(W / (max(xs) - min(xs) + 1e-9), H / (max(ys) - min(ys) + 1e-9))
    cx, cy = (max(xs) + min(xs)) / 2, (max(ys) + min(ys)) / 2
    zb = [-1e30] * (W * H)
    px = bytearray(b'\xf4\xf4\xf2' * (W * H))
    light = (0.35, -0.8, 0.55)
    ln = math.sqrt(sum(c * c for c in light))
    light = tuple(c / ln for c in light)
    for t in T:
        (x0, d0, y0), (x1, d1, y1), (x2, d2, y2) = t
        ux, uy, uz = x1 - x0, d1 - d0, y1 - y0
        vx, vy, vz = x2 - x0, d2 - d0, y2 - y0
        nx, ny, nz = uy * vz - uz * vy, uz * vx - ux * vz, ux * vy - uy * vx
        nl = math.sqrt(nx * nx + ny * ny + nz * nz)
        if nl == 0:
            continue
        nx, ny, nz = nx / nl, ny / nl, nz / nl
        if ny > 0:                                        # face the viewer
            nx, ny, nz = -nx, -ny, -nz
        shade = 0.35 + 0.65 * max(0, nx * light[0] + ny * light[1] + nz * light[2])
        col = bytes((int(90 * shade + 40), int(140 * shade + 50), int(200 * shade + 40)))
        sx = [W / 2 + (p[0] - cx) * s for p in t]
        sy = [H / 2 - (p[2] - cy) * s for p in t]
        minx, maxx = max(0, int(min(sx))), min(W - 1, int(max(sx)) + 1)
        miny, maxy = max(0, int(min(sy))), min(H - 1, int(max(sy)) + 1)
        den = (sy[1] - sy[2]) * (sx[0] - sx[2]) + (sx[2] - sx[1]) * (sy[0] - sy[2])
        if abs(den) < 1e-9:
            continue
        for y in range(miny, maxy + 1):
            for x in range(minx, maxx + 1):
                l0 = ((sy[1] - sy[2]) * (x - sx[2]) + (sx[2] - sx[1]) * (y - sy[2])) / den
                l1 = ((sy[2] - sy[0]) * (x - sx[2]) + (sx[0] - sx[2]) * (y - sy[2])) / den
                l2 = 1 - l0 - l1
                if l0 < -1e-4 or l1 < -1e-4 or l2 < -1e-4:
                    continue
                z = -(l0 * d0 + l1 * d1 + l2 * d2)        # nearer = larger
                i = y * W + x
                if z > zb[i]:
                    zb[i] = z
                    px[i * 3:i * 3 + 3] = col
    raw = b''.join(b'\0' + bytes(px[y * W * 3:(y + 1) * W * 3]) for y in range(H))

    def chunk(k, d):
        c = struct.pack('>I', len(d)) + k + d
        return c + struct.pack('>I', zlib.crc32(k + d))

    return (b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', W, H, 8, 2, 0, 0, 0))
            + chunk(b'IDAT', zlib.compress(raw, 6)) + chunk(b'IEND', b''))


if __name__ == '__main__':
    az, el = (float(sys.argv[3]), float(sys.argv[4])) if len(sys.argv) > 4 else (-35, 30)
    open(sys.argv[2], 'wb').write(render(load(sys.argv[1]), az, el))
