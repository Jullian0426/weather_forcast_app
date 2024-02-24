# Weather Forecasting App

## Overview

The Weather Forecasting App is a Ruby on Rails application that allows users to create and manage multiple locations to view a 7-day weather forecast. Utilizing the Open-Metro API, this app provides users with up-to-date weather information, including high and low temperatures for each day. The application supports user authentication, enabling users to have personalized location lists.

## Features

- **User Authentication**: Secure login and registration functionality.
- **Location Management**: Users can add, view, and delete locations.
- **Weather Forecast**: Displays a 7-day weather forecast for each location, highlighting temperature highs and lows.

## Deployment

Explore the deployed Heroku application at https://powerful-plains-28912-285c3a4c3812.herokuapp.com/

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby
- Rails
- PostgreSQL

### Setup

1. **Clone the repository**
```sh
git clone https://github.com/<your-github-username>/weather-forecasting-app.git
cd weather-forecasting-app
```

2. **Install Dependencies**
```sh
bundle install
```

3. **Setup the Database**
```sh
rails db:create db:migrate
```

4. **Start the Server**
```sh
rails server
```

5. **Running Tests**  
To run the automated test suite, execute:
```sh
bundle exec rspec
```