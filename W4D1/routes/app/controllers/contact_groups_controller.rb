class ContactGroupsController < ApplicationController
  def index

  end

  def create
    contact_group = ContactGroup.new(contact_groups_params)
    if contact_group.save
      render json: contact_group
    else
      render(
        json: contact_group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    contact_group = ContactGroup.update(params[:id], contact_groups_params)
    if contact_group.save
      render json: contact_group
    else
      render(
        json: contact_group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    render json: ContactGroup.find(params[:id])
  end

  def delete
    contact_group = ContactGroup.find(params[:id])
    contact_group.destroy
    render json: contact_group
  end

  private

  def contact_groups_params
    params[:contact_group].permit(:group_id, :contact_id, :user_id)
  end
end
