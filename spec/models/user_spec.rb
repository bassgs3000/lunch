require "spec_helper"

describe User do
  it { should be_kind_of ActiveRecord::Base }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :remember_me }
  it { should respond_to :name }

  it { should respond_to :entries }
  it { should respond_to :restaurants }
end
