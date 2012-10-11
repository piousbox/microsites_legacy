
require 'test_helper'

class My::PagesControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
    @admin = users(:admin)
    
    @no_4 = Fabricate :no_user
    @no_1 = Fabricate :no_user_1
    
    @p = Page.create :name => 'About', :seo => 'h5gt4rf3', :no_user => NoUser.from_user(@admin)
    
    #
    # create page for me
    
    nome = NoUser.where( :email => @no_4.email ).first
    if nome.blank?
      nome = NoUser.where( :email => @no_4.email ).savev
    end
    @nome = nome
    
    
  end
  
#  test 'get index' do
#    sign_in :user, @admin
#    
#    @controller = My::PagesController.new
#    get :index
#    
#    pages = assigns :pages
#    assert_not_nil pages
#    assert_equal 'Page', pages[0].class.name
#    
#  end
#  
#  test 'get new - qualquer usario logado posso criar uma pagina' do
#    sign_in :user, @user
#    
#    get :new
#    assert_response :success
#    
#    assert_contains 'light_semantic'
#    
#    page = assigns :page
#    assert page.is_a? Page
#    
#  end

end
