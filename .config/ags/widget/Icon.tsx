import { Gtk } from "ags/gtk4"
import { run } from "../lib/utils"

/** Botão simples de ícone com padding, usado na barra. */
export default function Icon({
  label,
  cmd,
  onClick,
  cssName,
}: {
  label: string
  cmd?: string
  onClick?: () => void
  cssName?: string
}) {
  return (
    <button
      class={cssName ?? "icon"}
      onClicked={() => (onClick ? onClick() : cmd && run(cmd))}
      valign={Gtk.Align.CENTER}
    >
      <label label={label} />
    </button>
  )
}
