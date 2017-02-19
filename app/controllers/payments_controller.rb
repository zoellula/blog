class PaymentsController < ApplicationController
  before_action :set_pay, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show

  end

  def new
    @user = User.new
	end

  def create
    #byebug
    #@user = User.new user_params.merge(email: stripe_params["stripeEmail"],
                                      #card_token: stripe_params["stripeToken"])
    #raise "Please, check registration errors" unless @user.valid?
    #@user.process_payment#
    #@user.save

    #redirect_to @user, notice: 'Registration was successfully created.'
    #rescue Exception => e
    #  flash[:error] = e.message

    customer = Stripe::Customer.create email: params[:stripeEmail],card: params[:stripeToken]

    Stripe::Charge.create customer: customer.id,
                          amount: 1000, #course.price * 100,
                          #description: course.name,
                          #source: "tok_19ifFXFEpiM6SXBBGGQlD6gg",
                          currency: 'usd'
    redirect_to articles_path

  end

  private
    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end

    #def set_pay
      #@user = User.find(params[:id])
    #end

    #def user_params
      #params.permit :email, :card_token, :utf8, :authenticity_token,
        #:full_name, :company, :telephone, :card_number, :card_verification, :exp_month, :exp_year, :commit
    #end
end
