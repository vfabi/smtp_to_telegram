# SMTPtg

Forked from [simplylizz/smtp_to_telegram](https://github.com/simplylizz/smtp_to_telegram) package.

`smtptg` is a small program which listens for SMTP and sends
all incoming Email messages to Telegram.

Say you have a software which can send Email notifications via SMTP.
You may use `smtptg` as an SMTP server so
the notification mail would be sent to the chosen Telegram chats.

## Getting started

Run:
```
docker run -p 25:25 -e ST_TELEGRAM_BOT_TOKEN=XXXXXXXXXXX -e ST_TELEGRAM_CHAT_IDS=XXXXXXXXX ghcr.io/muratovas/smtptg:latest
```

Request to check the service:
```
curl \
  --url 'smtp://localhost:25' \
  --mail-from sender@test.test \
  --mail-rcpt user@test.test --mail-rcpt user1@test.test \
  -H "Subject: Test smtptg" -F '=(;type=multipart/mixed' -F "=This message came via smtp;type=text/plain" -F '=)'
```

Sending personal messages is supported. Instead of email, enter an entry like `000000000@telegram.org`. Where `000000000` is `chat id`.
Classic emails will still be sent to the `ID` specified in `ST_TELEGRAM_CHAT_IDS`.

## Options

A custom format might be specified as well:
```
ST_TELEGRAM_BOT_TOKEN=<BOT_TOKEN>
ST_TELEGRAM_CHAT_IDS=<CHAT_ID1>,<CHAT_ID2> # optional
ST_TELEGRAM_MESSAGE_TEMPLATE="Subject: {subject}\\n\\n{body}" # optional
ST_SMTP_ALLOWED_HOSTS=cvzilla.net,example.com # optional
```

The default Telegram message format is:
```
From: {from}\\nTo: {to}\\nSubject: {subject}\\n\\n{body}\\n\\n{attachments_details}
```
