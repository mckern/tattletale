# Tattletale: stop snitching.

Question: How do you **know** when a cronjob finished?
Better yet, how do you know that ALL of your cronjobs finished? Most of the time, you just don't. Sure, cron sends some emails but most admins file those in the bitbucket. Most of the time we find out that a cronjob failed because whatever we were counting on it doing didn't happen.

![Tattletale screenshot](/doc/screenshots/tattletale.jpg?raw=true)

And thus at [Monitorama 2013](http://monitorama.com) hackathon, Tattletale was born. Register your job with Tattletale, then call the unique URL Tattletale provides (or the one you specified) at the end of your job (if it completes successfully, of course), and Tattletale does the rest. Each job has a state, and each state (<tt>ok</tt>, <tt>late</tt>, <tt>paused</tt>, and <tt>pending</tt>) has its own visual appearance, making it easy to tell what's going on with a glance.

Here's a contrived (and useless) example in Bash:
```bash
#!/bin/bash

cat<<EOM
Billy Quizboy: White! White, I'm being kidnapped by Zeus!
Pete White: That's what I've been telling you. That's why you should eat more fiber.
EOM

curl --silent --location http://tattletale.mydomain.local/masterbillyquizboy
exit 0
```

# Will Tattletale ever manage cron jobs?

Tattletale is intended to roll-up completion status for the cron jobs you've already got, not manage the cron jobs that have grown unwieldly. If you've got a need for managing cron jobs (where they run, when they run, who they run as, or worse: building complex workflows based on the completion status of your job chain) then Tattletale is not the tool for you! Might I suggest [Chronos](http://airbnb.github.io/chronos/) by [airbnb](https://www.airbnb.com)? It's so much more than Tattletale could ever, ever be.

# License & To-Do

Tattletale is licensed under the MIT license, and it's a work in progress. It was written to scratch an itch, and as such it has some rough edges. Here's the pending To-Do list that I'm working from:

* Tests... because I sort of punted on those
* Output **reliable** and **useful** json metadata for jobs like
  * Check-in history
  * Job details
  * Approximate run time (subtract the scheduled start from the actual check-in)
* ~~Validate that job URLs don't accidentally map onto controller actions~~
* ~~Verify that generated or specified job URLs are truly unique~~
    * Abandon specifying URLs?
* Move this To-Do list into github issues?
* Documentation
  * Setup
  * Dependencies
  * Usage examples
* Replace toy "authentication" with [Omniauth](https://github.com/intridea/omniauth) for pluggable authentication
* Retention plan for job check-ins (maybe [acts_as_trashable](https://github.com/bdurand/acts_as_trashable)?)
  * Use Sidekiq to clean them up in the background?
* Adapt [Bootstrap](http://twitter.github.com/bootstrap/) and clean up the custom (messy) CSS
* Spit & polish (code, not UI)
