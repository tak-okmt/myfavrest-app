FROM ruby:2.6.5
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs \
    && rm -rf /var/lib/apt/lists/*

##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /usr/local/src
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT