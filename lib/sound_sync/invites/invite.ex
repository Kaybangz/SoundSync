defmodule SoundSync.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :invitee_phone, :string
    field :status, :string, default: "pending"
    field :sent_at, :naive_datetime
    field :responded_at, :naive_datetime

    belongs_to :space, SoundSync.Spaces.Space
    belongs_to :inviter, SoundSync.Accounts.User
    belongs_to :invitee, SoundSync.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [
      :invitee_phone,
      :status,
      :sent_at,
      :responded_at,
      :space_id,
      :inviter_id,
      :invitee_id
    ])
    |> validate_required([:invitee_phone, :space_id, :inviter_id])
    |> validate_inclusion(:status, ["pending", "accepted", "declined", "expired"])
    |> validate_format(:invitee_phone, ~r/^\+?[1-9]\d{1,14}$/)
    |> foreign_key_constraint(:space_id)
    |> foreign_key_constraint(:inviter_id)
    |> foreign_key_constraint(:invitee_id)
  end

  def create_changeset(invite, attrs) do
    invite
    |> changeset(attrs)
    |> put_change(:sent_at, NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second))
    |> put_change(:status, "pending")
  end
end
