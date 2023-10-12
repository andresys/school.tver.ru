class Root::NavigationController < SuperAdminController
  def index
    # @about = GlobalPage.find_by_permalink('about')
    # @to_teacher = GlobalPage.find_by_permalink('to_teacher')
    @about = GlobalPage.find(1)
    @to_teacher = GlobalPage.find(2)
  end
end