# Initialize mail observers
ActionMailer::Base.register_observer(Promote::Observer::MailObserver)
