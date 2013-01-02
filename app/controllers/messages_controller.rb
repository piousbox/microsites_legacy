
class MessagesController < ApplicationController
  
  load_and_authorize_resource

  def create
    @m = Message.new(params[:message])
    @m.to_email = 'piousbox@gmail.com'
    
    respond_to do |format|
      if @m.save
        format.html { render 'success' }
        format.json { render :json => @subscription, :status => :created, :location => @subscription }
      else
        format.html { render :action => "new" }
        format.json { render :json => @subscription.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end