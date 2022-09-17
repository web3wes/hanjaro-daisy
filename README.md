## Notes

This is a Vue3 app hosted on Heroku with a Postgres DB. The legacy name for this app was Hangullo, so things in the code may still reflect that at this point.

(Bug/Prevent-Auto-login is the most current branch)

## Usage

Hanjaro is intended to help users easily convert the Hanja characters that sino korean characters are based into english, by scraping https://www.sayjack.com/ at the time of the request.

To use, add a single Hanja character to the input and select search

Example:

全 should yeild "maintain, keep whole or intact" under the word column.

## Known issues and planned updates

1: Currently the app only takes in a single hanja character, but it's more realistic to provide to at least two cahracters.

Future iterations will accept: - Mutiple Hanja (i.e. 文章) characters - Mutiple Hangul (i.e. 문장) cahracters - Return the Hanja characters under the Word column - Return the english definition under the Definition column

2: Though searching is a good starting point. The next phase of the app aims to include saving searched words, and reviewing in flashcards.

[![Built with Cookiecutter](https://img.shields.io/badge/built%20with-Cookiecutter-ff69b4.svg?logo=cookiecutter)](https://github.com/cookiecutter/cookiecutter)

# Hanjaro

## Setup

### Docker

If this is your first time...

1. [Install Docker](https://www.docker.com/)
1. Run `pipenv lock` to generate a Pipfile.lock
1. Run `cd client && npm install` so you have node_modules available outside of Docker
1. Back in the root directory, run `make build`
1. View other available scripts/commands with `make commands`

Now you will only ever need one command:
`make run` or `docker compose up`

### Backend

If not using Docker...
See the [backend README](server/README.md)

### Frontend

If not using Docker...
See the [frontend README](client/README.md)

## Testing

1. `pipenv install --dev`
1. `pipenv run pytest server/hangullo`

1. `npm run cypress`
