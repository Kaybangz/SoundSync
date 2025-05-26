defmodule SoundSync.Spaces.SpaceMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "space_members" do
    field :joined_at, :naive_datetime

    belongs_to :space, SoundSync.Spaces.Space
    belongs_to :user, SoundSync.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(space_member, attrs) do
    space_member
    |> cast(attrs, [:joined_at, :space_id, :user_id])
    |> validate_required([:space_id, :user_id])
    |> foreign_key_constraint(:space_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:space_id, :user_id], message: "User is already a member of this space")
  end

  def create_changeset(space_member, attrs) do
    space_member
    |> changeset(attrs)
    |> put_change(:joined_at, NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second))
  end
end
