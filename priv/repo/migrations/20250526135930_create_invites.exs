defmodule SoundSync.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :space_id, references(:spaces, on_delete: :delete_all), null: false
      add :inviter_id, references(:users, on_delete: :delete_all), null: false
      add :invitee_phone, :string, null: false
      add :invitee_id, references(:users, on_delete: :nilify_all), null: true
      add :status, :string, default: "pending", null: false
      add :sent_at, :naive_datetime
      add :responded_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:invites, [:space_id])
    create index(:invites, [:inviter_id])
    create index(:invites, [:invitee_id])
    create index(:invites, [:invitee_phone])
    create index(:invites, [:status])

    create unique_index(:invites, [:space_id, :invitee_phone],
             where: "status = 'pending'",
             name: :unique_pending_invites_per_space_phone
           )

    create constraint(:invites, :valid_status,
             check: "status IN ('pending', 'accepted', 'declined', 'expired')"
           )
  end
end
