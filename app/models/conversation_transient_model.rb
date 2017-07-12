class ConversationTransientModel
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :recipients, :subject, :body
  before_validation :clear_empty_recipients
  validates :recipients, presence: true
  validates :subject, presence: true
  validates :body, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  private

  def clear_empty_recipients
    recipients.select! { |recipient| !recipient.empty? }
  end
end
