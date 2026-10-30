import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"
import { run } from "../lib/utils"

type Ws = {
  id: number
  name: string
  windows: number
  monitorID: number
}

/** Lê os workspaces do Hyprland via hyprctl. */
async function readWorkspaces(): Promise<{ workspaces: Ws[]; active: number }> {
  try {
    const [ws, active] = await Promise.all([
      execAsync(["hyprctl", "workspaces", "-j"]),
      execAsync(["bash", "-lc", "hyprctl activeworkspace -j | jq -r .id"]),
    ])
    const parsed: Ws[] = JSON.parse(ws)
    return {
      workspaces: parsed.sort((a, b) => a.id - b.id),
      active: Number(active),
    }
  } catch {
    return { workspaces: [], active: -1 }
  }
}

export default function Workspaces() {
  const state = createPoll(
    { workspaces: [] as Ws[], active: -1 },
    500,
    async () => readWorkspaces(),
  )

  return (
    <box class="workspaces" valign={Gtk.Align.CENTER}>
      {state((s) => {
        // garante 1..10 sempre visíveis
        const byId = new Map(s.workspaces.map((w) => [w.id, w]))
        const ids = Array.from({ length: 10 }, (_, i) => i + 1)
        return ids.map((id) => {
          const ws = byId.get(id)
          const active = s.active === id
          const occupied = !!ws && ws.windows > 0
          const cls = active ? "ws active" : occupied ? "ws occupied" : "ws empty"
          return (
            <button
              class={cls}
              onClicked={() => run(`hyprctl dispatch workspace ${id}`)}
              valign={Gtk.Align.CENTER}
            >
              <label label={active || occupied ? "●" : "○"} />
            </button>
          )
        })
      })}
    </box>
  )
}
