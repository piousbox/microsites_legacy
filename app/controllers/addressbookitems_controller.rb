
class AddressbookitemsController < ApplicationController

  layout 'organizer'
  
  def index
    authorize! :index, Addressbookitem.new
    @addressbookitems = Addressbookitem.all.where( :user => @current_user )

    unless params[:addressbookitems].blank?
      keyword = params[:addressbookitems][:name]
      keyword ||= params[:keyword]
      if keyword
        @addressbookitems = @addressbookitems.where( :name => /#{keyword}/ )
      end
    end
    
    @addressbookitems = @addressbookitems.page( params[:addressbookitems_page] )

    respond_to do |format|
      format.html do
        render
      end
      format.json do
        render :json => @addressbookitems
      end
    end
  end

  def new
    @addressbookitem = Addressbookitem.new
    authorize! :new, @addressbookitem
  end

  def create
    @addressbookitem = Addressbookitem.new params[:addressbookitem]
    @addressbookitem.user = @current_user
    authorize! :create, @addressbookitem
    
    if @addressbookitem.save
      flash[:notice] = 'Success'
      redirect_to addressbookitems_path
    else
      flash[:error] = 'No Luck'
      render :action => :new
    end
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
  
end
