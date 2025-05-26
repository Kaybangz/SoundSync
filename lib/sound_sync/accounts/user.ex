defmodule SoundSync.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :phone_number, :string
    field :username, :string
    field :profile_picture_url, :string
    field :password_hash, :string
    field :session_expires_at, :naive_datetime

    has_many :created_spaces, SoundSync.Spaces.Space, foreign_key: :creator_id
    has_many :space_memberships, SoundSync.Spaces.SpaceMember
    has_many :spaces, through: [:space_memberships, :space]
    has_many :sent_invites, SoundSync.Invites.Invite, foreign_key: :inviter_id
    has_many :received_invites, SoundSync.Invites.Invite, foreign_key: :invitee_id
    has_many :messages, SoundSync.Messages.Message

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :phone_number,
      :username,
      :profile_picture_url,
      :password_hash,
      :session_expires_at
    ])
    |> validate_required([:phone_number, :username, :password_hash])
    |> validate_format(:phone_number, ~r/^\+?[1-9]\d{1,14}$/)
    |> validate_length(:username, min: 3, max: 20)
    |> unique_constraint(:phone_number)
    |> unique_constraint(:username)
  end
end
