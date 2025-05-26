defmodule SoundSync.Repo.Migrations.CreateSpaceMembers do
  use Ecto.Migration

  def change do
    create table(:space_members) do
      add :space_id, references(:spaces, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :joined_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:space_members, [:space_id])
    create index(:space_members, [:user_id])
    create unique_index(:space_members, [:space_id, :user_id])
  end
end
