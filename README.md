# hubot-pivotaltracker-notifier
[![wercker status](https://app.wercker.com/status/47bd9e783c1a1224b9fde838756dcb91/s/master "wercker status")](https://app.wercker.com/project/bykey/47bd9e783c1a1224b9fde838756dcb91)
[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-pivotaltracker-notifier.svg?style=flat)](https://coverals.io/r/1syo/hubot-pivotaltracker-notifier)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-pivotaltracker-notifier.svg?style=flat)](https://david-dm.org/1syo/hubot-pivotaltracker-notifier)

A hubot script that notify about status in Pivotal Tracker

See [`src/pivotaltracker-notifier.coffee`](src/pivotaltracker-notifier.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-pivotaltracker-notifier --save`

Then add **hubot-pivotaltracker-notifier** to your `external-scripts.json`:

```json
["hubot-pivotaltracker-notifier"]
```

## PivotalTracker configuration

Configure your PivotalTracker webhook:

Url: <hubot host>:<hubot port>/<hubot name>/pivotaltracker/<room>

See also:
http://www.pivotaltracker.com/help/integrations?version=v5#activity_web_hook

## Notification examples

If you use slack adapter then your notice use Slack attachments.

### Slack Adapter

![](https://raw.githubusercontent.com/wiki/1syo/hubot-pivotaltracker-notifier/slack.png)

### Slack Adapter (fallback)

![](https://raw.githubusercontent.com/wiki/1syo/hubot-pivotaltracker-notifier/slack-fallback.png)

### Shell Adapter

![](https://raw.githubusercontent.com/wiki/1syo/hubot-pivotaltracker-notifier/shell.png)
