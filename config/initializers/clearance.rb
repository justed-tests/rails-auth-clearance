# user may be suspended
class SuspendedCheckGuard < Clearance::SignInGuard
  def call
    if suspended?
      failure('Your account suspended')
    else
      next_guard
    end
  end

  def suspended?
    current_user.suspended?
  end
end

Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = 'reply@example.com'
  config.rotate_csrf_on_sign_in = true
  config.sign_in_guards = [SuspendedCheckGuard]
end
