# Tests for PHP hardening

This is currently in development! Please come back later.


## Standalone Usage

You can target the integration tests to any host were you have ssh access

rake -T gives you a list of suites you can run (well ignore directories which are obviously not suites for now)

```
± rake -T
rake serverspec:data_bags  # Run serverspec suite data_bags
rake serverspec:default    # Run serverspec suite default
```

run it with:

```
bundle install

# default user and ssh-key

bundle exec rake serverspec:default target_host=<name-or-ip-of-target-server>

# or with user, host, password

ASK_LOGIN_PASSWORD=true bundle exec rake serverspec:default target_host=192.168.1.222 user=stack
```

add `format=html|json` to get a report.html or report.json document


## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
