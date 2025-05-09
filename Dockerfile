FROM ruby:3.2.2

WORKDIR /srv/jekyll

RUN apt-get update -qq && apt-get install -y nodejs build-essential

COPY . .

# Add a fake gemspec if none exists
RUN test -f *.gemspec || echo "Gem::Specification.new do |spec|; spec.name = 'dummy'; spec.version = '0.1.0'; spec.summary = 'dummy'; spec.authors = ['dummy']; spec.files = Dir['**/*']; end" > dummy.gemspec

RUN gem install bundler -v 2.3.25 && bundle _2.3.25_ install

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
