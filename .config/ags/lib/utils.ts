import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

/** Roda um comando em shell sem travar a UI, ignorando erros. */
export function run(cmd: string) {
  execAsync(["bash", "-lc", cmd]).catch(() => {})
}

/** Relógio no formato informado (ex: "%H:%M"), atualizado a cada segundo. */
export function clock(format = "%H:%M") {
  return createPoll("", 1000, ["bash", "-lc", `date "+${format}"`])
}

/** Roda um comando em shell periodicamente e devolve a saída como texto. */
export function poll(cmd: string, intervalMs: number) {
  return createPoll("", intervalMs, ["bash", "-lc", cmd])
}

export type ModuleJson = { text: string; class: string }

/** Roda um script que emite JSON e devolve os campos text/class. */
export function pollJson(cmd: string, intervalMs: number) {
  return createPoll<ModuleJson>(
    { text: "", class: "" },
    intervalMs,
    async () => {
      try {
        const out = await execAsync(["bash", "-lc", cmd])
        return JSON.parse(out) as ModuleJson
      } catch {
        return { text: "", class: "" }
      }
    },
  )
}
