FROM ruby:2.6.5
# apt-utils関連のエラーを表示させないようにする
ENV DEBCONF_NOWARNINGS yes
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential \ 
                       libpq-dev \      
                       nodejs \
                       && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成、設定
RUN mkdir /myapp
WORKDIR /myapp

# ホスト側（ローカル）のGemfileを追加する
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
COPY . /myapp