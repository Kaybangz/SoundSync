defmodule SoundSync.Songs.Song do
  use Ecto.Schema
  import Ecto.Changeset

  schema "songs" do
    field :deezer_song_id, :string
    field :title, :string
    field :artist, :string
    field :album, :string
    field :duration, :integer
    field :played_at, :naive_datetime

    belongs_to :space, SoundSync.Spaces.Space
    belongs_to :added_by, SoundSync.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [
      :deezer_song_id,
      :title,
      :artist,
      :album,
      :duration,
      :played_at,
      :space_id,
      :added_by_id
    ])
    |> validate_required([:deezer_song_id, :title, :artist, :space_id, :added_by_id])
    |> validate_length(:title, min: 1, max: 200)
    |> validate_length(:artist, min: 1, max: 200)
    |> validate_number(:duration, greater_than: 0)
    |> foreign_key_constraint(:space_id)
    |> foreign_key_constraint(:added_by_id)
    |> unique_constraint(:deezer_song_id)
  end

  def create_changeset(song, attrs) do
    song
    |> changeset(attrs)
    |> put_change(:played_at, NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second))
  end
end
