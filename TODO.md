* Tests... because I sort of punted on those
* Output **reliable** and **useful** json metadata for jobs like
  * Check-in history
  * Job details
  * Approximate run time (subtract the scheduled start from the actual check-in)?
* ~~Validate that job URLs don't accidentally map onto controller actions~~
* ~~Verify that generated or specified job URLs are truly unique~~
    * Abandon specifying URLs?
* Move this To-Do list into github issues?
* Documentation
  * Setup
  * Dependencies
  * Usage examples
* Replace toy "authentication" with [Omniauth](https://github.com/intridea/omniauth) for pluggable authentication
* Retention plan for job check-ins
  * Maybe [acts_as_trashable](https://github.com/bdurand/acts_as_trashable)?)
  * Use [Sidekiq](http://mperham.github.io/sidekiq/) to clean them up in the background?
* Adapt [Bootstrap](http://twitter.github.com/bootstrap/)?
  * At least clean up the custom (messy) CSS
* Spit & polish (code, not UI)
