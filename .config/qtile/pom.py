tsst = 1
def get_time():
    try:
        import json
        with open("/home/mo/code/control.json","r") as f:
            time = json.load(f)['time']
            return time
    except:
        return "error"
import json
def stop_time():
    with open("/home/mo/code/control.json","r")as f:
        t = json.load(f)
    if t["c"]==0:
        t["c"]=1
    else:
        t["c"]=0    
    with open("/home/mo/code/control.json","w")as f2:
        json.dump(t,f2)    
