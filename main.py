import tkinter as tk
from tkinter import messagebox
import clips
import os
import json


class ExpertSystemGUI:
    def __init__(self, master):
        self.master = master

        self.text_resources = self.load_resources("strings.json")

        self.master.title(self.text_resources.get("app_title", "Expert System"))
        self.master.geometry("700x650")
        self.master.configure(bg="#f0f0f0")

        self.env = clips.Environment()

        if not os.path.exists("what_to_watch.clp"):
            messagebox.showerror("Error", self.text_resources.get("error_file", "File not found!"))
            self.master.destroy()
            return

        try:
            self.env.load("what_to_watch.clp")
            self.env.reset()
        except clips.ClipsError as e:
            messagebox.showerror("CLIPS Error", f"{self.text_resources.get('error_clips', 'Error')}: {e}")
            self.master.destroy()
            return

        self.header_label = tk.Label(master, text=self.text_resources.get("app_title", "Expert System"),
                                     font=("Helvetica", 18, "bold"), bg="#f0f0f0", pady=20)
        self.header_label.pack()

        self.content_frame = tk.Frame(master, bg="#f0f0f0")
        self.content_frame.pack(expand=True, fill="both", padx=20, pady=20)

        self.run_inference_cycle()

    def load_resources(self, filepath):
        if not os.path.exists(filepath):
            return {}
        try:
            with open(filepath, "r", encoding="utf-8") as f:
                return json.load(f)
        except Exception:
            return {}

    def get_text(self, section, key):
        if section in self.text_resources and key in self.text_resources[section]:
            return self.text_resources[section][key]
        return key

    def run_inference_cycle(self):
        self.header_label.config(text=self.text_resources.get("app_title", "Expert System"))

        self.env.run()

        for widget in self.content_frame.winfo_children():
            widget.destroy()

        ui_fact = None
        recommendation_fact = None

        for fact in self.env.facts():
            tmpl = fact.template.name
            if tmpl == 'ui-state':
                ui_fact = fact
            elif tmpl == 'recommendation':
                recommendation_fact = fact

        if recommendation_fact:
            self.show_result(recommendation_fact)
        elif ui_fact:
            self.show_question(ui_fact)
        else:
            tk.Label(self.content_frame,
                     text=self.text_resources.get("msg_inference_end", "Inference ended."),
                     bg="#f0f0f0").pack()

    def show_question(self, fact):
        q_id = fact['id']
        options = list(fact['options'])

        display_text = self.get_text("questions", q_id)

        lbl = tk.Label(self.content_frame, text=display_text,
                       font=("Arial", 14), bg="#f0f0f0", wraplength=600)
        lbl.pack(pady=(0, 20))

        for opt in options:
            btn_text = self.get_text("answers", opt)
            tk.Button(self.content_frame, text=btn_text,
                      font=("Arial", 12), width=30, pady=5, bg="white",
                      command=lambda q=q_id, a=opt: self.submit_answer(q, a)).pack(pady=5)

    def submit_answer(self, question_id, answer_value):
        fact_str = f'(answer (id "{question_id}") (value "{answer_value}"))'
        self.env.assert_string(fact_str)

        for fact in self.env.facts():
            if fact.template.name == 'ui-state':
                fact.retract()
                break

        self.run_inference_cycle()

    def show_result(self, fact):
        res_key = fact['value']
        res_text = self.get_text("results", res_key)

        self.header_label.config(text=self.text_resources.get("msg_match", "Match found!"))

        lbl = tk.Label(self.content_frame, text=res_text,
                       font=("Helvetica", 16, "bold"), fg="#2E8B57", bg="#f0f0f0", wraplength=600)
        lbl.pack(pady=30)

        btn_frame = tk.Frame(self.content_frame, bg="#f0f0f0")
        btn_frame.pack(pady=20)

        tk.Button(btn_frame, text=self.text_resources.get("button_restart", "Start Over"),
                  command=self.restart_system, bg="#4682B4", fg="white", padx=20, pady=10).pack(side="left", padx=10)

    def restart_system(self):
        self.env.reset()
        self.header_label.config(text=self.text_resources.get("app_title", "Expert System"))
        self.run_inference_cycle()


if __name__ == "__main__":
    root = tk.Tk()
    app = ExpertSystemGUI(root)
    root.mainloop()