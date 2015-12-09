class Account < ActiveRecord::Base
  # def password handlers

  # def other fun stuff with bcrypt
  include BCrypt

  # set password
  def password=(password)
    self.password_hash = BCrypt::Password.create(password)
  end

  # get password
  def password
    BCrypt::Password.new(self.password_hash)
  end

  # authenticate!
  def self.authenticate(username, password)
    user = Account.find_by(name: username)
    return user if user.password == password
  end

  def self.register(username, password)
    # make new user
    new_user = Account.create(name: username, password: password)
    # save
    new_user.save

    # stupid simple logic this could be WAYYYY BETTER
    if (new_user.name == username)
      return new_user
    else
      return false
    end
  end

end
