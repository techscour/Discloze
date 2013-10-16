class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:destroy]

  # GET /invitations
  # GET /invitations.json
 def index

  fetcher = lambda { |sort_field, direction, page, per|
    records = Invitation.joins(:partner).where(:public_id => @user_id)
    [records.count, records.order(sort_field + ' ' + direction).page(page).per(per)]
  }

  cooker = lambda  { |raws|
    raws.map do |raw|
      {
        'id' => raw.id,
        'headline' => raw.headline,
        'list' => raw.list,
        'partner'  => raw.partner.name,
        'posted'  => raw.posted,
        'html'  => raw.html
      }
    end
  } 

   callbacks = {
        :delete => {:controller => 'invitations' }
      }

   columns = [  
      {field:'headline', displayName: 'Headline', order: 'headline'},
      {field:'list', displayName: 'List', order: 'list'},
      {field:'partner', displayName: 'Partner', order: 'partners.name'},
      {field:'posted', displayName:'Posted', order: 'posted'}
   ]

   angular_grid_simple_helper 'shared/angular_grid_partial', 'Your Invitations', \
     fetcher, cooker, columns, callbacks
  end

  def create
    @invitation = Invitation.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        render :json => "ok"
      else
        render :json => "failed"
      end
    end
  end

  def destroy
    @invitation.destroy
    render :json => "ok"
  end

  private
    def set_invitation
      @invitation = Invitation.where(:id=>params[:id],:public_id => @user_id).first
    end

    def invitation_params
      params.require(:invitation).permit(:public_id, :partner_id, :headline, :list, :html, :posted, :effective, :expires)
    end
end
