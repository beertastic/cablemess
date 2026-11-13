#!/usr/bin/env python3
"""cablemess: (what it does, in one line).

Runs forever in its container: once a day at RUN_AT (HH:MM, local time), or every INTERVAL_MIN minutes if set.
`python3 app.py --once` runs a single pass and exits (for testing)."""
import datetime as dt
import os
import smtplib
import sys
import time
from email.message import EmailMessage

DATA = os.environ.get("DATA_DIR", "/data")
RUN_AT = os.environ.get("RUN_AT", "07:00")
INTERVAL_MIN = int(os.environ.get("INTERVAL_MIN", "0"))


def log(msg):
    print(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), msg, flush=True)


def send_mail(subject, body, html=None, to=None):
    """Mail through the SMTP account in .env (SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS, MAIL_FROM, MAIL_TO)."""
    m = EmailMessage()
    m["Subject"], m["From"], m["To"] = subject, os.environ["MAIL_FROM"], to or os.environ["MAIL_TO"]
    m.set_content(body)
    if html:
        m.add_alternative(html, subtype="html")
    port = int(os.environ.get("SMTP_PORT", "587"))
    cls = smtplib.SMTP_SSL if port == 465 else smtplib.SMTP
    with cls(os.environ["SMTP_HOST"], port, timeout=30) as s:
        if port != 465:
            s.starttls()
        s.login(os.environ["SMTP_USER"], os.environ["SMTP_PASS"])
        s.send_message(m)


def run_once():
    log("run: nothing to do yet")


def seconds_to_next_run():
    if INTERVAL_MIN:
        return INTERVAL_MIN * 60
    h, m = map(int, RUN_AT.split(":"))
    now = dt.datetime.now()
    nxt = now.replace(hour=h, minute=m, second=0, microsecond=0)
    if nxt <= now:
        nxt += dt.timedelta(days=1)
    return (nxt - now).total_seconds()


if __name__ == "__main__":
    os.makedirs(DATA, exist_ok=True)
    if "--once" in sys.argv:
        run_once()
        sys.exit(0)
    log(f"started; {'every %d min' % INTERVAL_MIN if INTERVAL_MIN else 'daily at ' + RUN_AT}")
    while True:
        time.sleep(seconds_to_next_run())
        try:
            run_once()
        except Exception as e:  # one bad run must not stop tomorrow's
            log(f"run failed: {e!r}")
