//
//  AppError.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Vapor

protocol AppError: AbortError, DebuggableError {}
