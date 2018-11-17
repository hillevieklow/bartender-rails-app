# Bartender

Welcome to Bartender! This Ruby on Rails app allows users to add cocktail recipes to a database, and search for recipes after ingredients.

## To Run this Program Locally:

```Fork and clone this repo```

### Enabling OmniAuth for FB login

```Follow instructions in .env template```

### Prerequisites
To install all necessary gems, run

```bundle install```

To set up database and add seed data, run

```rails db:migrate```

then

```rails db:seed```

### Deploy the program on a local server

To deploy the program in the browser, run

```thin start --ssl```

Navigate to ```https://localserver:3000/``` to get started.


## Built With

* [Ruby on Rails](http://rubyonrails.org) - Web framework
* [OmniAuth](https://github.com/omniauth/omniauth) - Third-party log in


## Authors

* **Hillevi Eklow** - [Hillevi Eklow @ github](https://github.com/hillevieklow)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* This project was built for Flatiron School's Full-Stack Web Development course.
