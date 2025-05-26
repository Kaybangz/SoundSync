defmodule SoundSync.Spaces.Space do
  use Ecto.Schema
  import Ecto.Changeset

  schema "spaces" do
    field :name, :string
    field :current_song_id, :string
    field :current_song_title, :string
    field :current_song_artist, :string
    field :current_song_url, :string
    field :is_active, :boolean, default: true
    field :song_started_at, :naive_datetime

    belongs_to :creator, SoundSync.Accounts.User

    has_many :space_members, SoundSync.Spaces.SpaceMember
    has_many :members, through: [:space_members, :user]
    has_many :invites, SoundSync.Invites.Invite
    has_many :messages, SoundSync.Messages.Message

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(space, attrs) do
    space
    |> cast(attrs, [
      :name,
      :current_song_id,
      :current_song_title,
      :current_song_artist,
      :current_song_url,
      :is_active,
      :song_started_at,
      :creator_id
    ])
    |> validate_required([:name, :creator_id])
    |> validate_length(:name, min: 1, max: 50)
    |> foreign_key_constraint(:creator_id)
  end
end
