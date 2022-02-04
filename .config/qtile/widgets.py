from libqtile.widget import  Clock , base
from subprocess import run



#####################################################
# expanding clock widget from issues 3139 https://github.com/qtile/qtile/issues/3139
#########################################################
class ExpandingClock(Clock):
    defaults = [
        ("long_format", "%A %d %B %Y | %H:%M", "Format to show when mouse is over widget."),
        ("animation_time", .1 , "Time in seconds for animation"),
        ("animation_step", 0.01, "Time in seconds for each step of the animation")
    ]

    def __init__(self, **config):
        Clock.__init__(self, **config)
        self.add_defaults(ExpandingClock.defaults)
        self.short_format = self.format
        self.current_length = 0
        self.toggled = False
        self.step = 0
        self.add_callbacks(
            {
                "Button1": self.toggle
            }
        )

    def _configure(self, qtile, bar):
        Clock._configure(self, qtile, bar)
        self.update(self.poll())
        self.target_length = self.layout.width + self.padding * 2

    def calculate_length(self):
        if not self.configured:
            return self.current_length

        if self.current_length == 0:
            return self.target_length

        return self.current_length

    def toggle(self):
        if self.toggled:
            self.format = self.short_format
        else:
            self.format = self.long_format

        self.toggled = not self.toggled
        self.update(self.poll())
        self.target_length = self.layout.width
        self.step = int((self.target_length - self.current_length) / (self.animation_time / self.animation_step))

        if self.step:
            self.timeout_add(self.animation_step, self.grow)

    def grow(self):
        target = self.layout.width + self.padding * 2

        self.current_length += self.step

        if self.step < 0:
            self.current_length = max(self.current_length, target)
        else:
            self.current_length = min(self.current_length, target)

        if self.current_length != target:
            self.timeout_add(self.animation_step, self.grow)

        self.bar.draw()
##################################################
#prayer time widget depnd on next prayer package https://aur.archlinux.org/packages/next-prayer/
##################################################
class Prayer(base.InLoopPollText):
    def __init__(self,interval:int, **config):
        base.InLoopPollText.__init__(self,**config)
        self.update_interval = interval 
    def get_prayer(self):
        n_prayer = str(run(['next-prayer','-i'],capture_output=True).stdout.decode("utf-8")).replace("\n", "").replace("AM",'').replace("PM",'')
        r_time = str(run(['next-prayer','-l'],capture_output=True).stdout.decode("utf-8")).replace("\n", "")[:5]
        out_put = f'{n_prayer}⏱️{r_time}'
        return out_put
    def poll(self):
        time  = self.get_prayer()
        return time

##################################################33

class TimeWarrior(base.InLoopPollText):
    def __init__(self,interval:int, **config):
        base.InLoopPollText.__init__(self,**config)
        self.update_interval = interval 
    def get_output(self):
        info = str(run('timew', capture_output=True).stdout).split("\\n")
        if len(info)==2:
            return "no task"
        return self.extract_time_and_task(info)
    def extract_time_and_task(self,info:list):
        info[0] = info[0].replace("b'Tracking ",'')   
        info[3] = info[3].replace("Total",'').strip()
        return f"{info[0]} {info[3][0:4]}"
    def poll(self):
        return self.get_output()

