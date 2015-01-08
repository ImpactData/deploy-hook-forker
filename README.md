# Deploy Hook Forker

Heroku only allows you to have one HTTP deploy hook. This app accepts a post to /:app and forwards the post and its params to all the urls listed for that app in the config file.

# Usage

### Clone this app and create a Heroku git remote

```sh
git clone https://github.com/ImpactData/deploy-hook-forker.git
cd deploy-hook-forker
heroku git:remote -a impact-data-deploy-hook-forker -r production
```

### Modify the config file

```yaml
your-heroku-app-name:
  slack: https://other.slack.com/services/hooks/heroku?token=INTENTIONALLY_LEFT_BLANK
  appsignal: https://push.appsignal.com/1/markers/heroku?api_key=INTENTIONALLY_LEFT_BLANK
  honeybadger: https://api.honeybadger.io/v1/deploys?deploy[environment]=production&api_key=INTENTIONALLY_LEFT_BLANK
another-heroku-app-name:
  honeybadger: https://api.honeybadger.io/v1/deploys?deploy[environment]=staging&api_key=INTENTIONALLY_LEFT_BLANK
```

### Once it's been merged into master, push it up to Heroku

```sh
git push production origin/master:master
```

### Point your app's HTTP deploy hook to the new Deploy Hook Forker app

```sh
heroku addons:add deployhooks:http --url=https://impact-data-deploy-hook-forker.herokuapp.com
```

This can also be done via the Heroku apps web UI.

## References

[Heroku deploy hook docs](https://devcenter.heroku.com/articles/deploy-hooks)
