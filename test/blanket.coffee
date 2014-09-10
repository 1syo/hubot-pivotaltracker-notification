require("blanket") {
  "data-cover-never": "node_modules"
  pattern: [
    "pivotaltracker-notifier.coffee"
    "postman.coffee"
    "postman/base.coffee"
    "postman/common.coffee"
    "postman/slack.coffee"
  ]
  loader: "./node-loaders/coffee-script"
}
