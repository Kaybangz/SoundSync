defmodule SoundSync.Repo.Migrations.CreateSpaces do
  use Ecto.Migration

  def change do
    create table(:spaces) do
      add :name, :string, null: false
      add :creator_id, references(:users, on_delete: :delete_all), null: false
      add :current_song_id, :string
      add :current_song_title, :string
      add :current_song_artist, :string
      add :current_song_url, :string
      add :is_active, :boolean, default: true
      add :song_started_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:spaces, [:creator_id])
  end
end
