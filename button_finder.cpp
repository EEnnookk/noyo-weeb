#include <cstdio>
#include <iostream>
#include <cstdlib>
#include <vector>
#include <string>

int main(int argc,char* argv[])
{
    if (argc < 2)
        return 1;
    const char mode = argv[1][0];
    int targetColor;
    if(mode != 'r' && mode != 'd')
        return 1;

    if(mode == 'r'){
        targetColor=375473;
    }else if (mode == 'd'){
        targetColor=255255255;
    }
    std::string command = std::string("./button_finder.sh ") + mode;

    FILE* pipe = popen(command.c_str(), "r");
    if (!pipe) return 1;

    std::vector<std::string> colors;
    char buffer[10000];

    while (fgets(buffer, sizeof(buffer), pipe)) {
        std::string line(buffer);
        if (!line.empty() && line.back() == '\n')
            line.pop_back();

        colors.push_back(line);

    }


    pclose(pipe);

    double btnStart = 0;
    double btnEnd = 0;

    // start point colors[colors.size() - 2];
    // coordinate step [for ((i=0;i<xi+=THIS))] colors[colors.size() - 2]

    const double STARTSAT = std::stod(colors[colors.size() - 1]);
    const int STEP = std::stoi(colors[colors.size() - 2]);

    colors[colors.size() - 1].clear();
    colors[colors.size() - 2].clear();

    int tolerance = 5;

    for (int i = 0;i + 1 < colors.size();i++) {
        int current = std::stoi(colors[i]);
        int next = std::stoi(colors[i+1]);

        bool currentMatch = std::abs(current - targetColor) <= tolerance;
        bool nextMatch = std::abs(next - targetColor) <= tolerance;
        
    if (btnStart == 0 && currentMatch && !nextMatch)
            btnStart = (i+1) * STEP;

        if (btnEnd == 0 && !currentMatch && nextMatch)
            btnEnd = i * STEP;

        //std::cout<< colors[i] << " " << colors[i+1]<< '\n';

        if (btnEnd != 0 && btnStart != 0)
            break;
    }

    //std::cout<< "Starts at: " << btnStart << '\n' << "Ends at: " << btnEnd << '\n';
    //std::cout<< "Starts at: " << STARTSAT + btnStart << '\n' << "Ends at: " << STARTSAT + btnEnd << '\n';
    std::cout << STARTSAT + (btnStart + btnEnd) / 2 << '\n';
    return 0;
}

