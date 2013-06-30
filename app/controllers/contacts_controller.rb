class ContactsController < ApplicationController
  load_resource only: :create

  before_filter :load_page

  def index
    @contact = Contact.new
  end

  def create
    if @contact.secret != 's3cr3t'
      flash[:alert] = I18n.t(:try_send_again)
      render action: "index"
    elsif @contact.save
      flash[:info] = I18n.t(:your_message_is_sent)
      redirect_to contacts_path
    else
      flash[:alert] = @contact.errors.full_messages.to_sentence
      render action: "index"
    end
  end

  private

  def load_page
    @page = Page.find_by_key('contact')
  end
end
