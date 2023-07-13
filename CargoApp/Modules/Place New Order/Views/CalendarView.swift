//
//  CalendarView.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 07.07.23.
//

import UIKit
import KDCalendar
import SnapKit

final class CalendarViewController: UIViewController {
    
    var callBack: ((Date)-> Void)?
    
    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .blue
        view.style.cellColorDefault = .cyan
        view.style.cellTextColorDefault = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = Date()
            self.calendarView.setDisplayDate(today, animated: false)
        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
    }
}

extension CalendarViewController: CalendarViewDataSource, CalendarViewDelegate {
    func calendar(_ calendar: KDCalendar.CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        return threeMonthsAgo
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        return threeMonthsAgo
    }

    func headerString(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy"
        let yearString = dateFormatter2.string(from: date)
        return "\(monthString) \(yearString)"
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didScrollToMonth date: Date) {
        
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didSelectDate date: Date, withEvents events: [KDCalendar.CalendarEvent]) {
        callBack?(date)
        navigationController?.popViewController(animated: true)
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didDeselectDate date: Date) {
        
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didLongPressDate date: Date, withEvents events: [KDCalendar.CalendarEvent]?) {
        
    }
    
    
}
