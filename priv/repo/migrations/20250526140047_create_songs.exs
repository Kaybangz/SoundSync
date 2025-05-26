defmodule SoundSync.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :space_id, references(:spaces, on_delete: :delete_all), null: false
      add :added_by_id, references(:users, on_delete: :delete_all), null: false
      add :deezer_song_id, :string, null: false
      add :title, :string, null: false
      add :artist, :string, null: false
      add :album, :string, null: true
      add :duration, :integer, null: true
      add :played_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:songs, [:space_id])
    create index(:songs, [:added_by_id])

    create index(:songs, [:space_id, :played_at])

    create unique_index(:songs, [:deezer_song_id])

    create constraint(:songs, :positive_duration, check: "duration IS NULL OR duration > 0")

    create constraint(:songs, :title_length,
             check: "char_length(title) >= 1 AND char_length(title) <= 200"
           )

    create constraint(:songs, :artist_length,
             check: "char_length(artist) >= 1 AND char_length(artist) <= 200"
           )
  end
end
