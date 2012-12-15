

class AddressbookitemsController < ApplicationController

  load_and_authorize_resource
  
  def index
    as = Addressbookitem.all.fresh.where( :user => @current_user )
    
    keyword = params[:addressbookitems][:name] unless params[:addressbookitems].blank?
    keyword ||= params[:keyword]
    if keyword
      as = as.where( :name => /#{keyword}/ )
    end
    
    as = as.page( params[:addressbookitems_page] )

    respond_to do |format|
      format.html do
        @addressbookitems = as
      end
      format.json do
        render :json => as
      end
    end
  end

  def new
    @addressbookitem = Addressbookitem.new
  end

  def create
    a = Addressbookitem.new params[:addressbookitem]
    a.user = current_user
    if a.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to addressbookitems_path
  end

  def edit
    ;
  end

  def update
    ;
  end

  def destroy
    ;
  end
  
  private

end