![Harvest Profit](https://www.harvestprofit.com/logo.png)

# React Programming Task
[![codecov](https://codecov.io/gh/HarvestProfit/react-programming-task/branch/master/graph/badge.svg)](https://codecov.io/gh/HarvestProfit/react-programming-task) [![CircleCI](https://circleci.com/gh/HarvestProfit/react-programming-task/tree/master.svg?style=svg)](https://circleci.com/gh/HarvestProfit/react-programming-task/tree/master)

This project has already been deployed to https://react-programming-challenge.herokuapp.com/, however you are free to deploy it under your own Heroku account by clicking this button:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This projects gives you an API to hid that allows you to create/update/manage a few different resources, via an authenticated API.

You should [Create a React App](https://github.com/facebook/create-react-app) that can:
- Handle authentication (you can create a user to authenticate with as part of the API)
- Handle the management of a logged in users projects
- Handle the management of each project's tasks

The API given is a relatively "flat" API. We include all `tasks` for a given `project`, to make rendering simpler.

Each endpoint is [documented here](https://documenter.getpostman.com/view/2582145/RWMEMTg7)

# Development

To get up and running in development, you will [this version of Ruby](./.ruby-version) and [this version of Node](./.node-version), as well as [Yarn](https://yarnpkg.com/en/).

Then run:
```bash
# Install all ruby deps
bundle install
# Install all JS deps
yarn install
# Generate a new Rails secret
rails secret
# Start the development server
rails s
```

# License
This project is [MIT Licensed](./LICENSE.md)
