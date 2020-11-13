# README

## Ruby Version
2.6.1

## Rails Version
6.0.3.4

## Installation
Clone this repo, run `rails db:migrate` to set up database, and run from the built in Rails server by running `rails s`.

## Google OAuth
You will need to set up your own Google OAuth. Set up an app on the Google Developer Console, create a `.env` file in the repo's home folder, then add the following code to that file.

```
GOOGLE_OAUTH_CLIENT_ID=[YOUR CLIENT ID GOES HERE]
GOOGLE_OAUTH_CLIENT_SECRET=[YOUR CLIENT SECRET GOES HERE]
```

## Contributing
Feel free to submit pull requests as you see fit.

## License
[MIT](https://choosealicense.com/licenses/mit/)
