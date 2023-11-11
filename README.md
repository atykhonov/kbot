# kbot

## Requirements

- [go v1.20](https://go.dev/doc/install)

## Installation

```
go build -ldflags "-X="github.com/atykhonov/kbot/cmd.appVersion=$(cat VERSION)
```

## Create a telegram bot

Go to `BotFarther` in telegram and send the following command:

```
You: /start
BotFarther: I can help you create and manage Telegram bots [...] 
```

Send the following command to create a new bot:

```
You: /newbot
BotFarther: Alright, a new bot. How are we going to call it? Please choose a name for your bot.
```

Choose a name for your bot:

```
You: kbot
BotFarther: Good. Now let's choose a username for your bot. It must end in `bot`. Like this, for example: TetrisBot or tetris_bot.
```

Choose a username for your bot:

```
You: foobarbaz_bot
BotFarther: Done! Congratulations on your new bot. [...]
```

Among all other information, you should get a token to access the HTTP API. Copy it to use for `TELEBOT_TOKEN` environment variable in the next steps.

## Start the application

Make `.env` file:

```
cp .env.sample .env
```

Update the `.env` file with the value of `TELEBOT_TOKEN`.

```
source .env
./kbot start
```

Go to your `foobarbaz_bot` (use the chosen bot's username) in telegram and send `/start` or `/start hello` commands.

Enjoy!