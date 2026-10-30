import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import Icon from "./Icon"
import Workspaces from "./Workspaces"
import {
  Clock,
  Hostname,
  Volume,
  SystemInfo,
  SystemBlock,
  Swaync,
} from "./Modules"
import { run } from "../lib/utils"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="centerbox">
        {/* ---- ESQUERDA ---- */}
        <box $type="start" spacing={6} valign={Gtk.Align.CENTER}>
          <Icon
            label=""
            cssName="launcher"
            cmd="~/.config/eww/scripts/menuctl.sh"
          />
          <Workspaces />
          <Hostname />
          <Icon
            label="󰋋"
            cmd="~/.config/eww/scripts/musicctl.sh"
          />
        </box>

        {/* ---- CENTRO ---- */}
        <box $type="center" valign={Gtk.Align.CENTER}>
          <Clock />
        </box>

        {/* ---- DIREITA ---- */}
        <box $type="end" spacing={6} valign={Gtk.Align.CENTER}>
          <SystemInfo />
          <Swaync />
          <Volume />
          <SystemBlock />
          <Icon label="" cmd="~/.config/eww/scripts/usrctl.sh" />
        </box>
      </centerbox>
    </window>
  )
}
