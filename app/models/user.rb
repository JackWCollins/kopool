class User < ActiveRecord::Base
  include TokenAuthenticable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :unverified_phones, -> { where(phone_verified: false) }

  before_save :set_phone_attributes,  if: :phone_verification_needed?
  after_save :send_sms_for_phone_verification, if: :phone_verification_needed?

  after_create :send_welcome_email

  has_many :pool_entries
  belongs_to :favorite_team, class_name: "NflTeam"

  validates_presence_of :email, case_sensitive: false
  validates_presence_of :encrypted_password

  def mark_phone_as_verified!
    update!(phone_verified: true, phone_verification_code: nil)
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def set_phone_attributes
    self.phone_verified = false
    self.phone_verification_code = generate_phone_verification_code

    self.phone.gsub!(/[\s\-\(\)]+/, '')
  end

  def send_sms_for_phone_verification
    PhoneVerificationService.new(user_id: id).process
  end

  def generate_phone_verification_code
    begin
      verification_code = SecureRandom.hex(3)
    end while self.class.exists?(phone_verification_code: verification_code)

    verification_code
  end

  def phone_verification_needed?
    phone.present? && phone_changed?
  end
end
