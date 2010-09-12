class PrelaunchSubscriber < ActiveRecord::Base
  validates_presence_of :email, :message => 'Please enter your email address first.'
  validates_uniqueness_of :email, :message => 'That email is already on the list.'
  validates_format_of :email,
    :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    :message => 'That email address doesn\'t look right.'

  after_save :add_to_mailing_list

  private

  def add_to_mailing_list
    subscriber = Campaigning::Subscriber.new(email)
    subscriber.add_and_resubscribe!(PRELAUNCH_CONFIG[:campaign_monitor_list_id])
  end
end
