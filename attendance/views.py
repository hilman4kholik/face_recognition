from django.shortcuts import render

def main_view(request):
    context ={
        'object': "obj"
    }
    return render(request, 'ratings/main.html', context)