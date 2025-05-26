defmodule SoundSync.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string

    belongs_to :space, SoundSync.Spaces.Space
    belongs_to :user, SoundSync.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :space_id, :user_id])
    |> validate_required([:content, :space_id, :user_id])
    |> validate_length(:content, min: 1, max: 500)
    |> foreign_key_constraint(:space_id)
    |> foreign_key_constraint(:user_id)
  end
end
