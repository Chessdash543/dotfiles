import { Gtk } from "ags/gtk4"
import { clock, poll, pollJson, run } from "../lib/utils"

/** Relógio central, abre o calendário do eww no clique. */
export function Clock() {
  const time = clock("%H:%M")
  return (
    <button
      class="clock"
      onClicked={() => run("~/.config/eww/scripts/calendar.sh")}
      valign={Gtk.Align.CENTER}
    >
      <label label={time} />
    </button>
  )
}

/** Hostname estático. */
export function Hostname() {
  const host = poll("hostname", 86400000)
  return (
    <box class="module hostname" valign={Gtk.Align.CENTER}>
      <label label={host((h) => ` ${h}`)} />
    </box>
  )
}

/** Volume via pamixer: clique muta, scroll ajusta 5%. */
export function Volume() {
  const vol = poll("pamixer --get-volume-human", 1000)

  return (
    <box class="module volume" valign={Gtk.Align.CENTER}>
      <button class="flat" onClicked={() => run("pamixer -t")}>
        <label label={vol((v) => ` ${v === "muted" ? "󰝟" : "󰕾"} ${v}`)} />
      </button>
    </box>
  )
}

/** Info de sistema (CPU/mem/uptime/kernel) via script da waybar. */
export function SystemInfo() {
  const info = pollJson("$HOME/.config/waybar/scripts/system-info.sh", 10000)
  return (
    <box class="module system-info" valign={Gtk.Align.CENTER}>
      <label label={info((i) => i.text)} />
    </box>
  )
}

/** Bateria / bloco crítico via script da waybar. */
export function SystemBlock() {
  const block = pollJson("$HOME/.config/waybar/scripts/system-block.sh", 5000)
  return (
    <button
      class={block((b) => `module system-block ${b.class ?? ""}`)}
      onClicked={() => run("wlogout")}
      valign={Gtk.Align.CENTER}
    >
      <label label={block((b) => b.text)} />
    </button>
  )
}

/** Botão de notificações do swaync com indicador de não lidas. */
export function Swaync() {
  const state = poll("swaync-client -swb", 1000)
  return (
    <button
      class="module swaync"
      onClicked={() => run("swaync-client -t -sw")}
      valign={Gtk.Align.CENTER}
    >
      <label label={state((s) => {
        let icon = "󰂚"
        if (s.includes("dnd")) icon = "󰂛"
        const hasNew = s.includes("notification") && s.includes("true")
        return hasNew ? `${icon}•` : icon
      })} />
    </button>
  )
}
